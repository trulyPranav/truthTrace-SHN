

![LangChain notion](https://github.com/TH-Activities/saturday-hack-night-template/assets/117498997/af58a18d-932c-4ee7-870b-20820cfa3f3f)




# truthTrace
A fact-checker application that compares and provides the result of how much accurate a particular fact is, along with its summary and source links!

## Team members
1. [Pranav M](https://github.com/trulyPranav)
2. [Abhiram A R](https://github.com/AbhiramAnanthu)
## Link to product walkthrough
[link to video](Link Here)
## How it Works ?
1. Explaining the working of project
2. Embed video of project demo
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
- Check the api, by accessing the '/' endpoint, using Postman or any other suitable api testing tools.
<pre>api requests must of the following json format:
{
  "user_input" : "{your prompt without these curly braces goes here}"
}</pre>

#### Running the app:
Do either of the following:
- Run the flutter frondend in the created virtual device. If the server connects, you'll be redirected to the chat screen, where you can type prompts and use the bot to check facts.
- Or check out the [Releases](https://github.com/trulyPranav/truthTrace-SHN/releases) and download the latest release, or if you're lazy like us, get the apk [here!](https://github.com/trulyPranav/truthTrace-SHN/releases/latest)
