import requests

response = requests.get("https://bucharjan.cz/response.txt")
print(response.text)
