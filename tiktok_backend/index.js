const express = require("express");
const app = express(); 
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const cors = require("cors"); 
const bodyParser = require("body-parser"); 



dotenv.config() ;



app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ limit: '50mb', extended: true }));
//parsing data 
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true, useNewUrlParser : true}));
// Use express-fileupload middleware


 // cors 
 app.use(cors());


// routes importation 
const videoRoute  = require("./routes/videoRoute"); 
const authRoute = require("./routes/authRoute");
const userRoute  = require("./routes/userRoute"); 
// routes implementation 
app.use("/api/video" , videoRoute); 
app.use("/api/auth", authRoute); 
app.use("/api/user", userRoute);


// DB connection 
mongoose.set('strictQuery', true);
mongoose.connect(process.env.DB);
  
// server connection 
app.listen(process.env.PORT || 3000,()=>{
    console.log("lintening on port ", process.env.PORT || 3000);

} );
