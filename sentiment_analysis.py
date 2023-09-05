# sentiment_analysis.py
import sys  # Importing the sys module to read command-line arguments
import nltk
nltk.download('vader_lexicon', quiet=True)

from nltk.sentiment.vader import SentimentIntensityAnalyzer
import json

sia = SentimentIntensityAnalyzer()

def analyze_sentiment(text):
    sentiment_score = sia.polarity_scores(text)
    sentiment_json = json.dumps(sentiment_score)
    return sentiment_json

if __name__ == "__main__":
    if len(sys.argv) > 1:  # Check if a command-line argument was provided
        text = sys.argv[1]  # Take the first command-line argument as the text
        print(analyze_sentiment(text))
    else:
        print("No text provided.")
