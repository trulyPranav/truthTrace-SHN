import requests
from bs4 import BeautifulSoup
from langchain_utils import link_generation

def scrap_body(url):
    session = requests.session()
    siteResponse = session.get(url)
    siteHtml = BeautifulSoup(siteResponse.content, 'html.parser')
    return siteHtml.body.text
    print(siteHtml.body.text)




