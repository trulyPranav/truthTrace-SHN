import requests
from bs4 import BeautifulSoup

url = "https://drugs.com"

need = input("Enter the drug you need to search about:")

newUrl = f"https://www.drugs.com/{need}.html"
session = requests.session()
siteResponse = session.get(newUrl)
siteHtml = BeautifulSoup(siteResponse.content, 'html.parser')
# sideEffects = siteHtml.find('ul')
h2_tag = siteHtml.find('h2', id="side-effects")
if h2_tag:
    # Get the next sibling element which contains the side effects
    side_effects_list = h2_tag.find_next('ul')
    if side_effects_list:
        # Extract each side effect item
        side_effects = [item.get_text(strip=True) for item in side_effects_list.find_all('li')]
        
        # Print or process the side effects
        for side_effect in side_effects:
            print(side_effect)
    else:
        print("No side effects list found.")
else:
    print("Header 'Fentanyl side effects' not found.")