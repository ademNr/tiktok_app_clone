const express = require("express");
const app = express(); 
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const cors = require("cors"); 
const bodyParser = require("body-parser"); 


dotenv.config() ;




//parsing data 
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true}));


 // cors 
 app.use(cors());


// routes importation 
const videoRoute  = require("./routes/videoRoute"); 
const authRoute = require("./routes/authRoute");
const userRoute  = require("./routes/userRoute"); 
// routes implementation 
app.use("/api" , videoRoute); 
app.use("/api", authRoute); 
app.use("/api", userRoute);


// DB connection 
mongoose.set('strictQuery', true);
mongoose.connect(process.env.DB, 
  
    {  useNewUrlParser : true }  
  );
  
// server connection 
app.listen(process.env.PORT || 3000,()=>{
    console.log("lintening on port ", process.env.PORT || 3000);

} );
