
const mongoose = require("mongoose"); 

const userSchema = new mongoose.Schema({

    followers : {
        type : [String], 
        default :  []
    }, 
    followings : {
        type : [String], 
        default :   [] 
    }, 
    likes : {
        type : [String], 
        default :   []
    }, 
    bio : {
        type : String, 
        default : ""
    },
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


 
     
   
},

{ timestamps:true }

);

module.exports = mongoose.model('User' , userSchema) ;