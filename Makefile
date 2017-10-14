define run
	@echo -n -e "\e[1;31m> "
	@echo -e $(1) | highlight -O ansi --syntax sh 
	@sh -c $(1) || true
endef

BIND=--dir=/examples=$(CURDIR)
BIND_SSL=--dir=/examples=$(CURDIR) --dir=/etc=/etc
META=meta.inf
CFLAGS=-std=c99

stack: stack.c
	$(call run, "gcc $(CFLAGS) -o $@ $<")
	$(call run, "isolate --init")
	$(call run, 'isolate --stack=1024 $(BIND) -M $(META) --run -- /examples/$@')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cleanup")

heap: heap.c
	$(call run, "gcc $(CFLAGS) -o $@ $<")
	$(call run, "isolate --init")
	$(call run, 'isolate --mem=8192 $(BIND) -M $(META) --run -- /examples/$@')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cleanup")

heap_cg: heap.c
	$(call run, "gcc $(CFLAGS) -o $@ $<")
	$(call run, "isolate --cg --init")
	$(call run, 'isolate -M $(META) $(BIND) --cg --cg-mem=8192 --run -- /examples/$@')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cg --cleanup")

heap_sparse_cg: heap_sparse.c
	$(call run, "gcc $(CFLAGS) -o $@ $<")
	$(call run, "isolate --cg --init")
	$(call run, 'isolate -M $(META) $(BIND) --cg --cg-mem=256 --run -- /examples/$@')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cg --cleanup")

heap_hugeblocks_cg: heap_hugeblocks.c
	$(call run, "gcc $(CFLAGS) -o $@ $<")
	$(call run, "isolate --cg --init")
	$(call run, 'isolate -M $(META) $(BIND) --cg --cg-mem=8193 --run -- /examples/$@')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cg --cleanup")

time_sleep_vs_cpu: time_sleep.c
	$(call run, "gcc $(CFLAGS) -o $@ $<")
	$(call run, "isolate --init")
	$(call run, 'isolate --time=0.1 $(BIND) -M $(META) --run -- /examples/$@')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cleanup")

time_sleep_vs_wall: time_sleep.c
	$(call run, "gcc $(CFLAGS) -o $@ $<")
	$(call run, "isolate --init")
	$(call run, 'isolate --wall-time=0.1 $(BIND) -M $(META) --run -- /examples/$@')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cleanup")

time_slow_vs_cpu: time_slow.c
	$(call run, "gcc $(CFLAGS) -o $@ $<")
	$(call run, "isolate --init")
	$(call run, 'isolate --wall-time=0.1 $(BIND) -M $(META) --run -- /examples/$@')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cleanup")

threads: threads.c
	$(call run, "gcc $(CFLAGS) -lpthread -o $@ $<")
	$(call run, "isolate --init")
	$(call run, 'isolate --processes=2 $(BIND) -M $(META) --run -- /examples/$@')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cleanup")

network:
	$(call run, "isolate --init")
	$(call run, 'isolate -E HOME=/box $(BIND) -M $(META) --run -- /bin/python3 /examples/network.py')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cleanup")

network_enabled:
	$(call run, "isolate --init")
	$(call run, 'isolate --share-net -E HOME=/box $(BIND_SSL) -M $(META) --run -- /bin/python3 /examples/network.py')
	$(call run, 'cat $(META)')
	$(call run, "isolate --cleanup")

clean:
	rm -f stack heap heap_cg heap_sparse_cg heap_hugeblocks_cg time_sleep_vs_wall time_sleep_vs_cpu time_slow_vs_cpu threads $(META)
