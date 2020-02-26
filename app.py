import flask
from flask import Flask, Response
import pandas as pd
from io import StringIO
app = Flask(__name__)
import pickle


model = pickle.load(open('lr_model', 'rb'))


def run_model(input):
    """Predictor function."""
    # reshape the flat [0, 255]-entry list into a [0, 1]-entry grid, as desired by the CNN.
    return model.predict(input)

@app.route('/invocations', methods=['POST'])
def predict():
    """
    Do an inference on a single batch of data.
    """

    X_train = flask.request.data.decode('utf-8')
    X_train = pd.read_csv(StringIO(X_train), header=None).values
    results = run_model(X_train)

    # format into a csv
    results_str = ",\n".join(results.astype('str'))

    return Response(response=results_str, status=200, mimetype='text/csv')
