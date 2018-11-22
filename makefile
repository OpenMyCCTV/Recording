OPENCV_INC_PATH='/usr/local/include'
OPENCV_LIB_PATH='/usr/local/lib/i386-linux-gnu'
BOOST_INC_PATH='./'
BOOST_LIB_PATH='/.'

ifeq ($(ocv), )
#3.4
OPENCV_DEP_LIB+=-lopencv_aruco
OPENCV_DEP_LIB+=-lopencv_bgsegm
OPENCV_DEP_LIB+=-lopencv_bioinspired
OPENCV_DEP_LIB+=-lopencv_calib3d
OPENCV_DEP_LIB+=-lopencv_ccalib
#OPENCV_DEP_LIB+=-lopencv_contrib
OPENCV_DEP_LIB+=-lopencv_core
OPENCV_DEP_LIB+=-lopencv_cvv
OPENCV_DEP_LIB+=-lopencv_datasets
OPENCV_DEP_LIB+=-lopencv_dnn
OPENCV_DEP_LIB+=-lopencv_dpm
OPENCV_DEP_LIB+=-lopencv_face
OPENCV_DEP_LIB+=-lopencv_features2d
OPENCV_DEP_LIB+=-lopencv_flann
OPENCV_DEP_LIB+=-lopencv_freetype
OPENCV_DEP_LIB+=-lopencv_fuzzy
#OPENCV_DEP_LIB+=-lopencv_gpu
OPENCV_DEP_LIB+=-lopencv_hdf
OPENCV_DEP_LIB+=-lopencv_highgui
OPENCV_DEP_LIB+=-lopencv_imgcodecs
OPENCV_DEP_LIB+=-lopencv_img_hash
OPENCV_DEP_LIB+=-lopencv_imgproc
#OPENCV_DEP_LIB+=-lopencv_legacy
OPENCV_DEP_LIB+=-lopencv_line_descriptor
OPENCV_DEP_LIB+=-lopencv_ml
#OPENCV_DEP_LIB+=-lopencv_nonfree
OPENCV_DEP_LIB+=-lopencv_objdetect
#OPENCV_DEP_LIB+=-lopencv_ocl
OPENCV_DEP_LIB+=-lopencv_optflow
OPENCV_DEP_LIB+=-lopencv_phase_unwrapping
OPENCV_DEP_LIB+=-lopencv_photo
OPENCV_DEP_LIB+=-lopencv_plot
OPENCV_DEP_LIB+=-lopencv_reg
OPENCV_DEP_LIB+=-lopencv_rgbd
OPENCV_DEP_LIB+=-lopencv_saliency
OPENCV_DEP_LIB+=-lopencv_shape
OPENCV_DEP_LIB+=-lopencv_stereo
OPENCV_DEP_LIB+=-lopencv_stitching
OPENCV_DEP_LIB+=-lopencv_structured_light
OPENCV_DEP_LIB+=-lopencv_superres
OPENCV_DEP_LIB+=-lopencv_surface_matching
OPENCV_DEP_LIB+=-lopencv_text
OPENCV_DEP_LIB+=-lopencv_tracking
OPENCV_DEP_LIB+=-lopencv_videoio
OPENCV_DEP_LIB+=-lopencv_video
OPENCV_DEP_LIB+=-lopencv_videostab
OPENCV_DEP_LIB+=-lopencv_viz
OPENCV_DEP_LIB+=-lopencv_xfeatures2d
OPENCV_DEP_LIB+=-lopencv_ximgproc
OPENCV_DEP_LIB+=-lopencv_xobjdetect
OPENCV_DEP_LIB+=-lopencv_xphoto


else
#3.3
OPENCV_DEP_LIB+=-lopencv_calib3d
OPENCV_DEP_LIB+=-lopencv_core
OPENCV_DEP_LIB+=-lopencv_features2d
OPENCV_DEP_LIB+=-lopencv_flann
OPENCV_DEP_LIB+=-lopencv_highgui
OPENCV_DEP_LIB+=-lopencv_imgcodecs
OPENCV_DEP_LIB+=-lopencv_imgproc
OPENCV_DEP_LIB+=-lopencv_ml
OPENCV_DEP_LIB+=-lopencv_objdetect
OPENCV_DEP_LIB+=-lopencv_photo
OPENCV_DEP_LIB+=-lopencv_shape
OPENCV_DEP_LIB+=-lopencv_stitching
OPENCV_DEP_LIB+=-lopencv_superres
OPENCV_DEP_LIB+=-lopencv_video
OPENCV_DEP_LIB+=-lopencv_videoio
OPENCV_DEP_LIB+=-lopencv_videostab


OPENCV_DEP_LIB+=-lopencv_calib3d
#OPENCV_DEP_LIB+=-lopencv_contrib
OPENCV_DEP_LIB+=-lopencv_core
OPENCV_DEP_LIB+=-lopencv_features2d
OPENCV_DEP_LIB+=-lopencv_flann
#OPENCV_DEP_LIB+=-lopencv_gpu
OPENCV_DEP_LIB+=-lopencv_highgui
OPENCV_DEP_LIB+=-lopencv_imgproc
#OPENCV_DEP_LIB+=-lopencv_legacy
OPENCV_DEP_LIB+=-lopencv_ml
OPENCV_DEP_LIB+=-lopencv_objdetect
#OPENCV_DEP_LIB+=-lopencv_ocl
OPENCV_DEP_LIB+=-lopencv_photo
OPENCV_DEP_LIB+=-lopencv_stitching
OPENCV_DEP_LIB+=-lopencv_superres
#OPENCV_DEP_LIB+=-lopencv_ts
OPENCV_DEP_LIB+=-lopencv_video
OPENCV_DEP_LIB+=-lopencv_videostab
endif

TARGET = Recording
VERSIONNUM = commitver

CC = gcc
LD = gcc

PREFIX=
VPATH = .

CXXFLAGS  = -I$(OPENCV_INC_PATH) -I$(BOOST_INC_PATH)  
CXXFLAGS += -I'./' -I'/usr/include/eigen3/'
CXXFLAGS += -O3 -g3 -Wall -std=c++11 -fopenmp -openmp

LIBS = -L$(OPENCV_LIB_PATH) -L$(BOOST_LIB_PATH) $(OPENCV_DEP_LIB) -lpthread -ldl -lm -lrt -lc -lstdc++ -lboost_system -lboost_thread -lboost_filesystem -lboost_regex -lgomp

SRCDIRS		= .

SRCS = $(foreach dir, . $(SRCDIRS),$(wildcard $(dir)/*.cpp))
#SRCS := $(notdir $(SRCS))

OBJS = $(SRCS:.cpp=.o)
#OBJS := $(notdir $(OBJS))
GITVERSION = "const char* version=\"version_$(shell git rev-parse HEAD)\";"

all: $(TARGET)

$(VERSIONNUM):
	echo $(SRCS)
	echo $(OBJS)
	echo $(GITVERSION) > VersionInfo.h

$(TARGET) : $(OBJS)
	$(CC) $^ -o $(TARGET) $(LIBS) $(SYSROOT)

%o:%cpp
	$(CC) $(CXXFLAGS) -c $< -o $@ $(SYSROOT)

clean:
	-rm -rf $(OBJS)
	-rm -f $(TARGET)
	-rm depend
	-rm VersionInfo.h 
	

depend: $(SRCS) $(VERSIONNUM)
	$(CC) -M $(CXXFLAGS) $^ > $(notdir $@)

-include depend
