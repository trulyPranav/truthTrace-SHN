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
dotenv_path = ".env"
load_dotenv(dotenv_path)

# Loading model
llm = ChatGroq(
    temperature=0.6, model="llama3-70b-8192", api_key=os.getenv("GROQ_API_KEY")
)

prompt_template = PromptTemplate.from_template(
    "this is a user's text:{user_input}\nthis is data from websites related to user's text:{headlines}\n.Compare the user's text with data from the provided websites and give an approximate percentage of how accurate the data is matching with user's text and at the end only show the percentage accuracy"
)

summary_template = prompt_template.from_template(
    "this is the output from the previous prompt {content}.summarize the content more short and effective way without loosing essentil parts and give the output as a summary and percent from the reply"
)

chain = prompt_template | llm
summary_chain = summary_template | llm


def compare_with_llm(user_input, content):
    result = chain.invoke({"user_input": user_input, "headlines": content})
    return result


def body_text(text):
    links = link_generation(text)
    for link in links:
        body = scrap_body(link)
    return body


search = GoogleSearchAPIWrapper(google_cse_id=os.getenv("GOOGLE_CSE_ID"))


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
        links.append(item["link"])
    return links


def link_generation(user_input):
    results = top_5_result(user_input)
    links = extract_links(results)
    return links


def summarizer(final_output):
    return summary_chain.invoke({"content": final_output})


def scrap_body(url):
    if url is not None:
        session = requests.session()
        siteResponse = session.get(url)
        if siteResponse.status_code == 200:
            siteHtml = BeautifulSoup(siteResponse.content, "html.parser")
            if siteHtml.body is not None:
                bodytxt = siteHtml.body.text
                words = bodytxt.split()
                return "".join(words[:6000])


# Initialize Flask application
app = Flask(__name__)


# Endpoint for POST requests
@app.route("/", methods=["POST"])
def process_request():
    # Get user input from POST data
    user_input = request.json["user_input"]

    # Process user input to get final result
    result = final_result(user_input)

    # Prepare JSON response
    response = {"output": result["output"], "source": result["source"]}

    return jsonify(response)


def final_result(text):
    content = body_text(text)
    result = compare_with_llm(text, content)
    sources = link_generation(text)
    final_result = summarizer(result)
    return {"output": final_result.content, "source": sources}


if __name__ == "__main__":
    app.run(debug=True)
