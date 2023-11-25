const User = require("../models/userModel"); 


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
const updateUserProfilePicture = async(req,res)=>{
    const userId = req.params.userId;
    const profilePicture = req.files.profilePicture;

    try {
        const user = await User.findOne({ userId}).exec();
        if (!user) {
            return res.status(404).json({ message: 'User not found' , success: false });
        }

        if (user.profilePicture) {

            const oldProfilePicturePath = path.join(user.profilePicture);
            console.log(__dirname)
            await fs.unlink(oldProfilePicturePath);

        }

        const fileName = user.userId + '_' + profilePicture.name;


        const savePath = path.join(__dirname, '..', 'upload', fileName); // Utilisation du répertoire 'uploads'
        user.profilePicture = `upload/${fileName}`;
        await profilePicture.mv(savePath);


        await user.save();

        user.password = undefined;
        res.status(200).json({success : true , user : user});
    } catch (err) {
        console.log(err);
        res.status(500).json({ error: err , success : false });
    }
}


module.exports = {getUserById, getUserProfilePicture, updateUserProfilePicture};