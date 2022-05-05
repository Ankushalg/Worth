from flask import Flask, request,jsonify
from flask_cors import CORS
import model

app = Flask(__name__) 
CORS(app)
 
# get user input and the predict the output and return to user
@app.route('/predict',methods=['POST'])
def predict():

    print("DEBUG | App.py :: Request: ", request) 
    #take data from form and store in each feature    
    bath = request.args.get('bathrooms')
    balcony = request.args.get('balcony')
    total_sqft_int = request.args.get('total_sqft_int')
    bhk = request.args.get('bhk')
    price_per_sqft = request.args.get('price_per_sqft')
    area_type = request.args.get('area_type')
    availability = request.args.get('availability')
    location = request.args.get('location')
     
    print("DEBUG | App.py ::: Data: Bath =", bath, "Balcony =", balcony, "Total Sqare Foot =", total_sqft_int, "BHK =", bhk, "Price Per Square Foot= ", price_per_sqft, "Area Type=", area_type, "Availablity =", availability, "Location =", location)
    # predict the price of house by calling model.py
    result = model.predict_house_price(bath,balcony,total_sqft_int,bhk,price_per_sqft,area_type,availability,location)       

    print("DEBUG | App.py :: Result: ", result)
    # return price
    return jsonify({'price':str(result)})
     
if __name__ == "__main__":
    app.run()