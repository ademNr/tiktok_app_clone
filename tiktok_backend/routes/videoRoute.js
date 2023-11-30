const videoController = require("../controllers/videoController")
const express = require('express');
const router = express.Router();
const multer = require("multer") ;



 // multer video upload configs
 const storageV = multer.diskStorage({
    destination: './videos',
    limits: {
        fileSize: 1000000,
      },
    filename: function(req, file, cb) {
        cb(null, file.originalname);
    }
});
// upload
const upload = multer({
    storage: storageV,
    limits: { fileSize: 1024 * 1024 * 100 },
    fileFilter: function(req, file, cb) {
        cb(null, true);
    }
});


router.post('/upload-video/:userId', upload.single('video'), videoController.uploadVideo);
router.get('/videos', videoController.getVideos);
router.get('/videos/:name', videoController.getVideoByName);
router.delete('/videos/:name', videoController.deleteVideoByName);

// get user videos by id 
router.get('/user-videos/:userId', videoController.getUserVideos);

module.exports = router ;
