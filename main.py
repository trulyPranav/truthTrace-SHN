from dotenv import load_dotenv
from langchain_google_genai import GoogleGenerativeAI
from langchain_core.prompts import PromptTemplate
from langchain_core.tools import Tool
from langchain_google_community import GoogleSearchAPIWrapper
import os

dotenv_path='.env'
load_dotenv(dotenv_path)

llm = GoogleGenerativeAI(model='gemini-1.5-flash',google_api_key=os.getenv('GOOGLE_API_KEY'))
prompt_template=PromptTemplate.from_template("compare the {user_prompt} with the following {headlines} also return how correct the person compared to the given content in percentage")


def compare_with_llm(content):
    chain = prompt_template | llm
    result = chain.invoke({"user_prompt":"does fentanyl cause headache","headlines":content})
    return result
end_result = compare_with_llm(content)
print(end_result)

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
    for link in links:
        print(link)

results=top_10_result("orangutan")
print(extract_links(results))

