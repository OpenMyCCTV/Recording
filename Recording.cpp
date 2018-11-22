#include <stdio.h>

//opencv
#include "opencv2/opencv.hpp"

int main(void)
{
	printf("Recording...\n") ;

	cv::VideoCapture cap(0); 
	
	while(1)
	{
		// Check if camera opened successfully
		if(!cap.isOpened())
		{
			//check for camera
		}
		else
		{
			cv::Mat frame;

			// Capture frame-by-frame
			cap >> frame;

			// If the frame is empty, break immediately
			if (!frame.empty())
			{
				// Display the resulting frame
				cv::imshow( "Frame", frame );

				// Press  ESC on keyboard to exit
				char c=(char) cv::waitKey(1);

				if(c==27)	break;
			}
		}
	};

	// When everything done, release the video capture object
	cap.release();

	// Closes all the frames
	cv::destroyAllWindows();
		
	return 0 ;
}
