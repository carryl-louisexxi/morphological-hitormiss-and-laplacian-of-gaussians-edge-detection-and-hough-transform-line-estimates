# morphological-hitormiss-&-laplacian-of-gaussians-edge-detection-&-hough-transform-line-estimates

Exercise 3A – ( 4% ) – Morphological HitorMis

Figure 1.Result of the hitormiss_test.m
![image](https://user-images.githubusercontent.com/69174836/151279843-00b27be9-03db-4eda-80d7-fac797efcee5.png)

Figure 2. Result of the chull_test.m
![image](https://user-images.githubusercontent.com/69174836/151279864-3ecc4a2d-b482-463b-84c5-994e4b36a1ad.png)

Figure 3. Result of the skel_test.m
![image](https://user-images.githubusercontent.com/69174836/151279885-14447892-7e73-401b-bd5a-b752620c9bbf.png)

Discussion:
Here, the resulting images are similar to those presented in the pdf. This indicates that we are able to properly construct a hit or miss transform. Formula:
 
Exercise 3B – ( 4% ) – Laplacian of Gaussians Edge Detection

Figure 1. LoG: Results after performing Laplacian of Gaussian Filter LoG Filter: Filter used
-	13 x 13 filter. Edges: Represents the detected edges.
![image](https://user-images.githubusercontent.com/69174836/151279950-9811636d-30a2-414c-82d4-8e38fb59f065.png)

Figure 2. LoG: Results after performing Laplacian of Gaussian Filter LoG Filter: Filter used
-	15 x 15 filter. Edges: Represents the detected edges.
 ![image](https://user-images.githubusercontent.com/69174836/151279976-bfd9504c-ce94-4670-976b-1f2b8a5340d6.png)


Figure 3. LoG: Results after performing Laplacian of Gaussian Filter LoG Filter: Filter used
-	11 x 11 filter. Edges: Represents the detected edges.
![image](https://user-images.githubusercontent.com/69174836/151280015-ddaf0f32-5a95-4405-81c1-0cd57d6dc5f0.png)

Figure 4. LoG: Results after performing Laplacian of Gaussian Filter LoG Filter: Filter used
-	13 x 13 filter. Edges: Represents the detected edges.
![image](https://user-images.githubusercontent.com/69174836/151280036-07cdd973-1018-4af8-97bb-a652bf099218.png)
 

Figure 5. (OWN TESTING CODE) LoG: Results after performing Laplacian of Gaussian Filter LoG Filter: Filter used
-	13 x 13 filter.
Edges: Represents the detected edges.
![image](https://user-images.githubusercontent.com/69174836/151280073-9808e45c-feb8-46c1-b8f8-df7929c7dbdd.png)


Discussion:

Here, to get the LoG output, I convolved the input image and the LoG filter. After that, I computed the threshold. The LoG output is then padded so that we can calculate all the points presented in the image. Next, I identify the zero crossing and preserve the point where the sum of the magnitudes of LoG output across the zero crossing is > t. As you can see, the results show that we are able to properly detect the edges of the image. I also observed that as my filter size becomes bigger the less we are able to detect an edge. I believe the reason for that is because when you perform LoG with a large filter our resulting image is blurry. Thus, making it hard to identify the zero crossing and preserve the points that are above the threshold. This implies that it becomes more challenging to detect images.
 
Exercise 3C: Hough Transform Line Estimates (3%)

Performing Hough Transform Line Estimate on “Box.tif”.

Figure 1. Left – input image. Right – detected edges of the input image (given already).
![image](https://user-images.githubusercontent.com/69174836/151280111-dda72902-4a69-4338-a535-48ffcdb3acc1.png)


Figure 2. Hough Transform - Detected Maxima. The image presented is in Hough Space form.
![image](https://user-images.githubusercontent.com/69174836/151280133-d1fcc786-eae5-4ff6-80cc-0ba6583dcf5e.png)

Figure 3. Line estimation of the detected maxima.
![image](https://user-images.githubusercontent.com/69174836/151280151-82502322-1c25-428c-978a-5a79c1a54c83.png)

 
Performing Hough Transform Line Estimate on lift edge image.

Figure 1. Left – input image. Right – detected edges of the input image (given already).
![image](https://user-images.githubusercontent.com/69174836/151280185-adc30b43-0b51-4dc8-8d12-8282aa80d2b2.png)

Figure 2. Hough Transform - Detected Maxima. The image presented is in Hough Space form.
![image](https://user-images.githubusercontent.com/69174836/151280206-df9ac1f6-21ab-417a-b864-bd42805f5e14.png)

Figure 3. Line estimation of the detected maxima.
![image](https://user-images.githubusercontent.com/69174836/151280228-15564920-7dcf-43ea-8800-639568c76d27.png)

Performing Hough Transform Line Estimate “OWN TESTING CODE”

Figure 1. Left – input image. Right – detected edges of the input image (I use a canny edge detector to detect edges here).
![image](https://user-images.githubusercontent.com/69174836/151280245-b98577d1-7297-4f73-90b1-babfe59e6d78.png)

Figure 2. Hough Transform - Detected Maxima. The image presented is in Hough Space form.
![image](https://user-images.githubusercontent.com/69174836/151280263-a33f4312-aa8d-4cb0-b717-34152a2ad72a.png)

Figure 3. Line estimation of the detected maxima.
![image](https://user-images.githubusercontent.com/69174836/151280281-fe602430-3d2b-45e3-bc80-cc2ed2ce06a2.png)

Discussion:
Here to get the maxima, I use a 7 x 7 mask and pass it through the Hough space of the image. The mask will check if the neighborhood contains a “peak”. After detecting, I record the rho and theta position of the peak.

Q: How well does the line finder work when the image contains many line structures?

The image above indicates that the line finder was able to detect efficiently the areas where peaks are high. I also observed that when I increase the number of lines the computing process becomes slower. It is worth noting also that the other detected maxima seems to converge a lot on areas where the highest peaks are located.
