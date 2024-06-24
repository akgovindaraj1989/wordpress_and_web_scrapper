import sys
import requests
from html.parser import HTMLParser

class MyHTMLParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.in_titleline = False
        self.in_link = False
        self.top_articles = []
        self.current_link = ""
        self.current_title = ""

    def handle_starttag(self, tag, attrs):
        attrs_dict = dict(attrs)
        if tag == "span" and attrs_dict.get("class") == "titleline":
            self.in_titleline = True
        if tag == "a" and self.in_titleline:
            self.current_link = attrs_dict.get("href", "")
            self.in_link = True
            
    def handle_data(self, data):
        if self.in_link:
            self.current_title = data

    def handle_endtag(self, tag):
        if tag == "span" and self.in_titleline:
            self.in_titleline = False
        if tag == "a" and self.in_link:
            self.in_link = False
            self.in_titleline = False

        if self.current_title and self.current_link:
                self.top_articles.append((self.current_title, self.current_link))                
                self.current_title = ""
                self.current_link = ""

def fetch_hacker_news_top_articles():
    url = 'https://news.ycombinator.com/'

    try:
        # Fetch the HTML content of the Hacker News homepage
        response = requests.get(url)
        html_content = response.text

        # Parse the HTML content using our custom HTML parser
        parser = MyHTMLParser()
        parser.feed(html_content)

        # Get the top 20 articles
        top_articles = parser.top_articles[:20]
        return (top_articles)

    except Exception as e:
        print(f"Error fetching or parsing data: {e}")
        return None

if __name__ == "__main__":
            
    top_articles = fetch_hacker_news_top_articles()

    if top_articles:        
            print("Top 20 articles on Hacker News:")
            for rank, (title, link) in enumerate(top_articles, start=1):
                print(f"{rank}. {title} - {link}")
    else:
        print("Failed to fetch Hacker News articles.")
