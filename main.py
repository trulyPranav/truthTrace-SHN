from dotenv import load_dotenv
from langchain_groq import ChatGroq
from langchain_core.prompts import PromptTemplate
from bs4 import BeautifulSoup
from langchain_core.tools import Tool
from langchain_google_community import GoogleSearchAPIWrapper
import os
import requests
from flask import Flask, request, jsonify

# Loading environment variables
dotenv_path = '.env'
load_dotenv(dotenv_path)

# Loading model
llm = ChatGroq(
    temperature=0.6,
    model="llama3-70b-8192",
)

prompt_template = PromptTemplate.from_template(
    "this is a user's text:{user_input}\nthis is data from websites related to user's text:{headlines}\n.Compare the user's text with data from the provided websites and give an approximate percentage of how accurate the data is matching with user's text and at the end only show the percentage accuracy"
)

def compare_with_llm(user_input, content):
    chain = prompt_template | llm
    result = chain.invoke({"user_input": user_input, "headlines": content})
    return result

def body_text(text):
    links = link_generation(text)
    for link in links:
        body = scrap_body(link)
    return body

search = GoogleSearchAPIWrapper()

def top_5_result(text):
    return search.results(text, 5)

tool = Tool(
    name="google_search",
    description="Search Google for recent results.",
    func=top_5_result,
)

def extract_links(results):
    links = []
    for item in results:
        links.append(item['link'])
    return links

def link_generation(user_input):
    results = top_5_result(user_input)
    links = extract_links(results)
    return links

def scrap_body(url):
    if url is not None:
        session = requests.session()
        siteResponse = session.get(url)
        if siteResponse.status_code == 200:
            siteHtml = BeautifulSoup(siteResponse.content, 'html.parser')
            if siteHtml.body is not None:
                return siteHtml.body.text

# Initialize Flask application
app = Flask(__name__)

# Endpoint for POST requests
@app.route('/', methods=['POST'])
def process_request():
    # Get user input from POST data
    user_input = request.json['user_input']

    # Process user input to get final result
    result = final_result(user_input)

    # Prepare JSON response
    response = {
        'output': result['output'],
        'source': result['source']
    }

    return jsonify(response)

def final_result(text):
    content = body_text(text)
    result = compare_with_llm(text, content)
    sources = link_generation(text)
    return {
        'output': result.content,
        'source': sources
    }

if __name__ == '__main__':
    app.run(debug=True)
