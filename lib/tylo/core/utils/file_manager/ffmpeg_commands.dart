
const String videoThumbnailCommand = '-ss 00:00:01 -frames:v 1';

const String reduceImageSizeCommandLowQuality = '-vf scale=iw*0.01:ih*0.01';

const String reduceImageSizeCommandGoodQuality = '-vf scale=iw*0.3:ih*0.3';

const String reduceVideoSizeCommand = '-b:v 700k -b:a 128k';

const String reduceAudioSizeCommand = '-b:a 128k';

