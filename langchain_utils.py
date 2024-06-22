from langchain_core.tools import Tool
from langchain_google_community import GoogleSearchAPIWrapper
from dotenv import load_dotenv

dotenv_path = '.env'
load_dotenv(dotenv_path)

search = GoogleSearchAPIWrapper()

def top_10_result(text):
    return search.results(text,5)

tool = Tool(
    name="google_search",
    description="Search Google for recent results.",
    func=top_10_result,
)

def extract_links(results):
    links = []
    for item in results:
        links.append(item['link'])
    return links

def link_generation(user_input):
    results=top_10_result(user_input)
    links=extract_links(results)
    return links
