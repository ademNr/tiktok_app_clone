// pubvideoController.js
const Video = require('../models/videoModel');
const path = require("path");


const uploadVideo = async(req, res) => {
    try {
        if (!req.file) {
            console.error('No file uploaded');
            return res.status(400).json({ message: 'No file uploaded' });
        }

        const newVideo = new Video({
            name: req.file.originalname,
            filePath: req.file.path,
            userId : req.params.userId
        });

        await newVideo.save();

        res.status(200).json({
            message: 'Video uploaded successfully',
            video: {
                _id: newVideo._id, // Inclure l'ID de la vidéo
                name: newVideo.name,
                filePath: newVideo.filePath,
                createdAt: newVideo.createdAt,
            }
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Internal server error' });
    }
};
// get user video
const getUserVideos = async(req, res) => {
   const  userId = req.params.userId ; 
    try {
        const videos = await Video.find({userId : userId});
        res.status(200).json({ success : true, data: videos });
    } catch (err) {
        console.error(err);
        res.status(500).json({ success : false });
    }
};

const getVideos = async(req, res) => {
    try {
        const videos = await Video.find();
        res.status(200).json({ message: 'Videos retrieved successfully.', data: videos });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'An error occurred while retrieving videos.' });
    }
};

const getVideoByName = async(req, res) => {
    try {
        const videoName = req.params.name;
        const video = await Video.findOne({ name: videoName });

        if (!video) {
            return res.status(404).json({ message: 'Video not found' });
        }

        const videoPath = path.join(__dirname, '..', video.filePath);

        // Envoyer la vidéo en tant que flux de données
        res.status(200).sendFile(videoPath);
    } catch (err) {
        console.error(err);
        res.status(500).send({ message: 'Internal server error' });
    }
};


const deleteVideoByName = async(req, res) => {
    try {
        const videoName = req.params.name;
        const deletedVideo = await Video.findOneAndDelete({ name: videoName });

        if (!deletedVideo) {
            return res.status(404).json({ message: 'Video not found' });
        }

        res.status(200).json({ message: 'Video deleted successfully', data: deletedVideo });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Internal server error' });
    }
};

module.exports = { uploadVideo, getVideos, getVideoByName, deleteVideoByName ,getUserVideos};