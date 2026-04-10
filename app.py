# life cycle

# 1.objective
# 2.data gathering
# 3.data cleaning
# 4.EDA 
# 5.Data Preprocessing
# 6.divide
# 7.train and test
# 8.model apply
# 9.evaluation
# 10.dump
# 11.deployement


from flask import Flask,request,jsonify

app=Flask(__name__)

@app.route("/")
def home():
    return "Hello Welcome to Flask"

@app.route("/about us")
def about():
    return "This is about us page"


@app.route("/user/<name>")
def add_user(name):
    return f"Hello Good Morning {name}"



@app.route("/add", methods=["POST"])
def add():
    data = request.get_json()
    if not data:
        return jsonify({"error": "No JSON received"}), 400

    total = data["num1"] + data["num2"]
    return jsonify({"result": total})

@app.route("/users",methods=["GET"])
def get_user():
    data=request.get_json()
    return jsonify({"data": data})



if __name__=="__main__":
    app.run(debug=True,port=5500)


