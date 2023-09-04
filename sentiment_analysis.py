import nltk
nltk.download('vader_lexicon', quiet=True)  # Download lexicon, suppress output messages

from nltk.sentiment.vader import SentimentIntensityAnalyzer
import json

# Initialize VADER
sia = SentimentIntensityAnalyzer()

def analyze_sentiment(text):
    # Get the sentiment score
    sentiment_score = sia.polarity_scores(text)

    # Convert the sentiment score dictionary to JSON format
    sentiment_json = json.dumps(sentiment_score)

    return sentiment_json

if __name__ == "__main__":
    text = "Your sample sentence here."
    print(analyze_sentiment(text))
