# Screen Space Motion Blur in TouchDesigner

Follow this article to implement:
http://john-chapman-graphics.blogspot.com201301per-object-motion-blur.html

![screenshots](https://raw.githubusercontent.com/yeataro/TD_KIWI/master/TD-ScreenSpaceMotionBlur/screenshot.jpg)
https://www.youtube.com/watch?v=gl0y-sRHwHg

## Process
Use Render Top and Shader below the target Geo Comp level to get 
the current World transform matrix, and point to the camera used by
the main Render Top to get the current camProj matrix 
(actually get worldCamProj directly)

Render the matrix as a texture and cache a frame,
transfer it to the object's shader, and calculate the previous
screen position value of the vertex on the current coordinates.

The unimplemented part is instance, you can try to cache the instance
data of the previous frame and pass it in with the unused attribute,
then expand and rewrite the TDDeform function to use this attribute.


The reason for using this process is because it is more convenient to
call this method to complete with the least custom nodes.

If the TD has a built-in series of Per-TDMatrix Uniforms 
(even the built-in Per-TDDeform() function, for instantiation)
(And I think it should be an option in Goe Comp and Camera Comp - to reduce performance overhead),
it will be easier to get the velocity map (Just need to use one Render Pass and GLSL Mat).

---
Yea Chen
yeataro@gmail.com
