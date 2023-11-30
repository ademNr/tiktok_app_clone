const userController  = require("../controllers/userController"); 
const express = require('express');
const router = express.Router();

// get user by id
router.get("/user/:userId", userController.getUserById);

// get user profile picture
router.get("/user-picture/:userId" , userController.getUserProfilePicture); 

// update user profile pic
router.put("/user-picture/:userId", userController.updateUserProfilePicture ); 

// update all user fields
router.put("/user/:userId", userController.updateUserFields);



module.exports = router ; 


