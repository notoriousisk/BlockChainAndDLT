from flask import Flask, request, jsonify
import hashlib
import time

app = Flask(__name__)

max_nonce = 2 ** 32  # 4 billion

def proof_of_work(header, difficulty_bits):
    target = 2 ** (256 - difficulty_bits)
    for nonce in range(max_nonce):
        hash_result = hashlib.sha256((str(header) + str(nonce)).encode()).hexdigest()

        if int(hash_result, 16) < target:
            return hash_result, nonce

    return None, nonce

@app.route('/proof_of_work', methods=['POST'])
def perform_proof_of_work():
    data = request.get_json()
    header =  data['header']
    difficulty_bits = data['difficulty_bits']

    start_time = time.time()
    hash_result, nonce = proof_of_work(header, difficulty_bits)
    end_time = time.time()
    elapsed_time = end_time - start_time

    result = {
        'hash_result': hash_result,
        'nonce': nonce,
        'elapsed_time': elapsed_time
    }
    
    print(result)
    return jsonify(result)

if __name__ == '__main__':
    app.run()

    
## To increase the speed of PoW function we can decrease difficulty_bits value 
# A higher value of difficulty_bits represents a more challenging problem, requiring the hash result to have more leading zeros. Conversely, a lower value of difficulty_bits makes the problem easier.  

## Also we simply can reduce the value of max_nonce to reduce the time to complete the whole program.
