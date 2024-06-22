from dotenv import load_dotenv
from langchain_groq import ChatGroq
from langchain_core.prompts import PromptTemplate
from scrap import scrap_body
from langchain_utils import link_generation
from scrap import scrap_body
import os

dotenv_path='.env'
load_dotenv(dotenv_path)

llm = chat = ChatGroq(
    temperature=0,
    model="llama3-70b-8192",
)

prompt_template=PromptTemplate.from_template("this is a user's text:{user_input}\nthis is data from websites related to user's text:{headlines}\n.Compare the user's text with data from the provided websites and give an approximate percentage of how accurate the data is matching with user's text and at the end only show the percentage accuracy")


def compare_with_llm(user_input,content):
    chain = prompt_template | llm
    result = chain.invoke({"user_input":user_input,"headlines":content})
    return result

def body_text(text):
    links = link_generation(text)
    body = ''
    if links is not None:
        # for link in links:
        #     body = scrap_body(link)
        print("hi")
    else: 
        print("hello")
    return body

def final_result(text):
    content = body_text(text)
    result = compare_with_llm(text,content)
    return content

def testing():
    prompt="Does fentanyl cause headache"
    content=scrap_body('https://www.drugs.com/')
    result=compare_with_llm(prompt,content)
    return result
print(testing())

