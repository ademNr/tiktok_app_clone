
const mongoose = require("mongoose"); 

const userSchema = new mongoose.Schema({
     profilePicture :{
        type : String 
     },
    email:{
        type : String , 
        required : true , 
        unique : true,

    },
     
    fullName : {
        type : String , 
        required : true 
    },
    userName: {
        type : String , 
        required : true,
        
        
    },

    password: {
        type : String , 
        required : true , 

    },

    photo : {
        type : String ,
        default : ""
    },
 
     
   
},

{ timestamps:true }

);

module.exports = mongoose.model('User' , userSchema) ;