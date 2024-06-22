import requests
from bs4 import BeautifulSoup

url = "https://drugs.com"

need = input("Enter the drug/disease you need to search about:")

newUrl = f"https://www.drugs.com/{need}.html"
session = requests.session()
siteResponse = session.get(newUrl)
siteHtml = BeautifulSoup(siteResponse.content, 'html.parser')

print(siteHtml.body.text)