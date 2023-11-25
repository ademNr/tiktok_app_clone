
const User = require("../models/userModel"); 
const bcrypt = require("bcrypt"); 

// register function
const register = async (req,res)=>{
    try {
        const { email, fullName, userName, password } = req.body;
    
        // Check if the user already exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
          return res.status(400).json({ error: 'User already exists', success : false });
        }
    
        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);
        
        const profilePicture = req.files ? req.files.profilePicture : null;

        if (profilePicture) {
            const filename = userName + '_' + profilePicture.name; // Utiliser le nom original du fichier
            console.log(filename)
            await profilePicture.mv(`upload/${filename}`);
            User.profilePicture = `upload/${filename}`;
            console.log(User.profilePicture)
        }
        // Create a new user
        const newUser = new User({
          email,
          fullName,
          userName,
          password: hashedPassword,
          profilePicture : profilePicture ? `${User.profilePicture}` : null,
        });
    
        // Save the user to the database
        await newUser.save();
    
        return res.status(201).json({ message: 'User registered successfully' , success : true});
      } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Internal server error', success : false });
      }
}

// login function 
 const login = async (req,res)=>{
    try {
        const { email, password } = req.body;
    
        // Check if the user exists
        const user = await User.findOne({ email });
        if (!user) {
          return res.status(401).json({ error: 'Invalid credentials', success : false });
        }
    
        // Compare the provided password with the hashed password in the database
        const passwordMatch = await bcrypt.compare(password, user.password);
        if (!passwordMatch) {
          return res.status(401).json({ error: 'Invalid credentials' , success : false});
        }
    
        // You can generate a token here if you want to implement authentication
    
        return res.status(200).json({ message: 'Login successful' , success : true});
      } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Internal server error' , success : false});
      }
 }

 module.exports = { register , login  };