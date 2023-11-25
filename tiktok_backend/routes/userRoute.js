const userController  = require("../controllers/userController"); 
const express = require('express');
const router = express.Router();

// get user by id
router.get("/user/:userId", userController.getUserById);

// get user profile picture
router.get("/user-picture" , userController.getUserProfilePicture); 

// update user profile



module.exports = router ; 


