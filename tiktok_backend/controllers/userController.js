const User = require("../models/userModel"); 
const path = require('path');
const fs = require('fs').promises;

const getUserById = async(req,res)=>{
    const userId = req.params.userId ; 
    try {
        const user = await User.findById(userId); 
        if(!user){
            res.status(400).json({success : false , message : "user not found"}); 
        }

        res.status(200).json({success : true , user : user , message: "user retrieved"});

    }catch(err){
        res.status(400).json({success : false , message :"server error"}); 

    }
}
// get user profile picture 
const getUserProfilePicture = async(req,res)=>{
    try {
        //getUserById(req, res)
        
        const userId = req.params.userId;
        const user = await User.findOne({userId});

        if (!user || !user.profilePicture) {
            return res.status(404).json({ message: "user not fount or there is no profile pic", success : false  });
        }
        
        // Charger l'image depuis le système de fichiers
        const fs = require('fs');
        const image = fs.readFileSync(user.profilePicture);

        // Renvoyer les données de l'image avec le type de contenu approprié
        res.writeHead(200, {
            'Content-Type': 'image/jpeg', // Modifier en fonction du type d'image
            'Content-Length': image.length
        });

        res.end(image);
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "error occured while getting the image ", success : false  });
    }
}

//updaet user Profile picture 
const updateUserProfilePicture = async (req, res) => {
    const userId = req.params.userId;

    try {
        // Check if the profilePicture file is present in the request
        if (!req.files || Object.keys(req.files).length === 0 || !req.files.profilePicture) {
            return res.status(400).json({ message: 'No profile picture file uploaded', success: false });
        }

        const profilePicture = req.files.profilePicture;
        const user = await User.findOne({ userId });

        if (!user) {
            return res.status(404).json({ message: 'User not found', success: false });
        }

        if (user.profilePicture) {
            const oldProfilePicturePath = path.join(__dirname, '..', user.profilePicture);

            try {
                await fs.unlink(oldProfilePicturePath);
                console.log('Old profile picture deleted successfully');
            } catch (unlinkError) {
                console.error('Error deleting old profile picture:', unlinkError.message);
            }
        }

        // Check if profilePicture.name is defined before using it
        const fileName = user.userId + (profilePicture.name ? '_' + profilePicture.name : '');
        const savePath = path.join(__dirname, '..', 'upload', fileName);
        user.profilePicture = `upload/${fileName}`;
        await profilePicture.mv(savePath);

        await user.save();

        user.password = undefined;
        res.status(200).json({ success: true, user: user });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal server error', success: false });
    }
};

// updating user fields 
const updateUserFields = async(req,res)=>{
    const userId = req.params.userId;

    try {
        const user = await User.findOne({ userId }).exec();
        if (!user) {
            return res.status(404).json({ message: 'User not found', success : false });
        }
        if (req.body.email) user.email = req.body.email;
        if (req.body.userName) user.userName = req.body.username;
        if (req.body.likes) user.likes = req.body.likes;
        if (req.body.followers) user.followers = req.body.followers;
        if (req.body.followings) user.followings = req.body.followings;
        if(req.body.bio) user.bio = req.body.bio; 
        if(req.body.password){
            const password = req.body.password; 
            const hash = await bcrypt.hash(password, 10);
            user.password = hash;
        }
        await user.save();

       
        res.status(200).json(user);
    } catch (err) {
        console.log(err);
        res.status(500).json({ error: err });
    }
}
module.exports = {getUserById, getUserProfilePicture, updateUserProfilePicture, updateUserFields};