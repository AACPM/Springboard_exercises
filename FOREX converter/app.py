from flask import flask, render_template, request
app = Flask(__name__)

@app.route('/convert', methods=['GET', 'POST'])


def convert():
    if request.method == 'POST':
        from_currency = request.form['from']
        to_currency = request.form['to']
        amount = request.form['amount']

        if not code(from_currency) or not code(to_currency):
            error_message = 'Invalid code'
            return render_template('index.html', error=error_message)

    return render_template('index.html')

def convert_code(from, to, amount):
    base_url = 'https://api.exchangerate.host/convert'
    params = {'from': from_currency, 'to': to_currency, 'amount': amount}

    try:
        response = request.get(base_url, params=params)
        data = response.json()
        if response.status_code == 200 and data.get('success'):
            converted = data.get('result')
            return f'{to_currency}{converted:.2f}'
        else: 
            return None

def code(currency_code):
    try:
        response = request.get('https://api.exchangerate-api.com/v4/latest/USD')
        if response.status_code == 200:
            data = response.json()
            valid_code = data.get('rates', {}).keys()
            return currency_code in valid_code
        else:
            return False
