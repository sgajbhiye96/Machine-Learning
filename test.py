# import requests

# url="http://127.0.0.1:5500/add"
# data={"num1":10,"num2":20}

# response = requests.post(url, json=data)

# print(response)


import requests

url = "http://127.0.0.1:5500/add"
payload = {"num1": 10, "num2": 20}

response = requests.post(url, json=payload)

print("Status:", response.status_code)
print("Response:", response.json())

url = "http://127.0.0.1:5500/users"
payload = {"user1":"Siddharth"}

response = requests.get(url, json=payload)

print("Status:", response.status_code)
print("Response:", response.json())

