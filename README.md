

![LangChain notion](https://github.com/TH-Activities/saturday-hack-night-template/assets/117498997/af58a18d-932c-4ee7-870b-20820cfa3f3f)




# truthTrace
A fact-checker application that compares and provides the result of how much accurate a particular fact is, along with its summary and source links! All the user needs to do is send a fact to be checked, and the app returns how accurate the fact is, why it is only accurate by a given percentage, and its source links, that claim the facts to be accurate.

## Team members
1. [Pranav M](https://github.com/trulyPranav)
2. [Abhiram A R](https://github.com/AbhiramAnanthu)
## Link to product walkthrough:
Will be uploaded by 24/6/24
[link to video](Link Here)
## How it Works ?
**1. Explaining the working of project:**
The project works in the following way:
- The user sends a prompt through the app or through the api.
- The google search feature embedded in the langchain framework is utilized, to find out the urls of the top 10 links of the search query related to the user's prompt.
- The texts of the body tags of the 10 links are entirely scraped, and are stored in a variable.
- Then a prompt template is used (a query) to compare the user's input and the scraped data, and is **summarized**.
- The summarized data and the 10 sourced links is then returned to the app/api calls as the result of the user's input.
- The accuracy of the fact the user mentioned is checked with the data fed by scraping, and a suitable accuracy percentage/percentage range is provided along with its summary and source links. 
**
2. Embed video of project demo:**
Will be uploaded by 24/6/24
## Libraries used
- Langchain
- BeautifulSoup4
- Flask
- Flutter

## How to configure

#### The Backend:
- Open your console. Activate virtual environments if any. Then install the dependencies by running the following command:<br> ```pip install -r requirements.txt```

#### The Frontend / Overall Project:
- Create an **android** virtual device, prefer android 11 and above.

## How to Run

#### Running the backend:
- Run ```python main.py``` in the console, to activate the flask localhost.
- The backend is deployed [here](https://truthtracebackend.onrender.com/), and this can also be used to access the api.
- Check the api, by accessing the '/' endpoint, using Postman or any other suitable api testing tools.
<pre>api requests must of the following json format:
{
  "user_input" : "{your prompt without these curly braces goes here}"
}</pre>

#### Running the app:
Do either of the following:
- Run the flutter frondend in the created virtual device. If the server connects, you'll be redirected to the chat screen, where you can type prompts and use the bot to check facts.
- Or if you're on a moobile device, check out the [latest release](https://github.com/trulyPranav/truthTrace-SHN/releases/latest) and download the latest .apk file, or if you're lazy like us, get the apk [here!]([https://github.com/trulyPranav/truthTrace-SHN/releases/latest](https://github.com/trulyPranav/truthTrace-SHN/releases/download/release1/truthTrace.apk))
