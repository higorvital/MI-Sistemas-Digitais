#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <stdlib.h>
#include <stdio.h>

using namespace cv;

/** @function main */
int main( int argc, char** argv )
{

  Mat src, src_gray;
  Mat grad;
  char* window_name = "Sobel Demo - Simple Edge Detector";
  int scale = 1;
  int delta = 0;
  int ddepth = CV_8U;

  int c;

  /// Load an image
  src = imread("C:/Users/lenna.png");

  if( !src.data )
  { return -1; }

  GaussianBlur( src, src, Size(3,3), 0, 0, BORDER_DEFAULT );

  /// Convert it to gray
  cvtColor( src, src_gray, CV_BGR2GRAY );

/*  int x = 0;
    int y = 0;
    for(x = 0;x < 220;x++){
        for(y = 0;y < 220;y++){
            Vec3b intensidade = src_gray.at<Vec3b>(y,x);
            printf("%d|%d|%d ",intensidade.val[0],intensidade.val[1],intensidade.val[2]);
            //printf("%d ",intensidade.val);
        }
      printf("\n");
    }*/

  /// Create window
  namedWindow( window_name, CV_WINDOW_AUTOSIZE );

  /// Generate grad_x and grad_y
  Mat grad_x, grad_y;
  Mat abs_grad_x, abs_grad_y;

  /// Gradient X
  //Scharr( src_gray, grad_x, ddepth, 1, 0, scale, delta, BORDER_DEFAULT );
  Sobel( src_gray, grad_x, ddepth, 1, 0, 3, scale, delta, BORDER_DEFAULT );
  convertScaleAbs( grad_x, abs_grad_x );

  /// Gradient Y
  //Scharr( src_gray, grad_y, ddepth, 0, 1, scale, delta, BORDER_DEFAULT );
  Sobel( src_gray, grad_y, ddepth, 0, 1, 3, scale, delta, BORDER_DEFAULT );
  convertScaleAbs( grad_y, abs_grad_y );

  /// Total Gradient (approximate)
  addWeighted( abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad );

  int x = 0;
  int y = 0;
  for(x = 0;x < grad.cols;x++){
      for(y = 0;y < grad.rows;y++){
          Vec3b intensidade = grad.at<Vec3b>(y,x);

          printf("%d|%d|%d ",intensidade.val[0],intensidade.val[1],intensidade.val[2]);
          //printf("%d ",intensidade.val);
      }
    printf("\n");
  }

  imshow( window_name, grad );

  waitKey(0);

  return 0;
  }

