from flask import Flask, request, jsonify

app = Flask(__name__)

from transformers import PegasusForConditionalGeneration, PegasusTokenizerFast

model_name = "google/pegasus-xsum"
model = PegasusForConditionalGeneration.from_pretrained(model_name)
tokenizer = PegasusTokenizerFast.from_pretrained(model_name)

# steps i followed  !!!
# pip install flask 
# pip3 install torch torchvision torchaudio
# pip install transformers

def main(text):
    
    inputs = tokenizer(text, truncation=True, padding="longest", return_tensors="pt")
    summary_ids = model.generate(inputs["input_ids"], num_beams=4, max_length=100, early_stopping=True)
    summary = tokenizer.decode(summary_ids[0], skip_special_tokens=True)

    return summary


@app.route('/', methods=['GET', 'POST'])
def handle_request():
    if request.method == 'POST':
        data = request.get_json()
        if 'content' not in data:
            error_message = {'error': 'Missing required field "value"'}
            return jsonify(error_message), 400
        
        result = main(data['content'])

        response = {'summerized': result, 'satuts': 'true'}
        return 
    
    else:
        response = {'satuts': 'working'}
        return jsonify(response)

# Start the server
if __name__ == '__main__':
    port = 4000
    app.run(port=port)
    print(f"Server is listening on port {port}")
