# CS 1XA3 Project02 - axentia


##Overview

This webpage is Alex Axenti's custom CV. My CV contains my skills, qualifications, jobs etc. as any other resume would, as well as 
pictures and description of side projects that I have worked on before. The design of the CV is based on a free template, and the
link can be found in 'References' at the bottom of this README.

## Custom Javascript Code

**NOTE:** The template came with some of its own javascript features. All of the javascript that I have coded can be found in
the file assets/js/main_marked.js while all the other js files have not been modified by me. Below, I will only describe the 
features which I have programmed.

### Information and Skills Display

**Description:** On the webpage, there is a section where 6 categories are displayed (Work experience, Education, etc.). This
javascript function detects which category was clicked, and changes the text of the paragraph above to a new text that is 
relevant to the category selected.

The code for this feature can be found on lines 103 - 147

### Information and Skills Highlight

**Description:** When hovering over one of the 6 categories mentioned above, this feature changes the highlight color of the hovered
category so it is clear as to which category is being selected, as well as for nice design.

The code for this feature can be found on lines 5 - 16

### Image Change on Click

**Description:** The webpage contains a section for 'Projects'. There, 3 projects are listed along with a picture and description.
This feature detecs when an image has been clicked on, and it changes the image to a new image of the same project, to give viewers
a better idea of the project I am describing. The images cycle through a loop.

The code for this feature can be found on lines 45 to 100

### Navigator Highlighter

**Description:** This feature simply boldens and enlarges the text that is being hovered on the navigator.

The code for this feature can be found on lines 19 to 30

### Footer Icon Animations

**Description:** At the footer of the navigator, there are 3 icons for github, linkedin and gmail. When hovering over an icon,
an animation causes the icon to swell up to indicate that it senses the hover, as well as for some cool design. Upon moving the
 mouse away from the icon, an animations causes the icon to shrink back to its original size.

The code for this feature can be found on lines 33 to 42

## References

- The free template used for this CV 
https://html5up.net/read-only

- A link I used regarding queueing and stopping animations
https://css-tricks.com/examples/jQueryStop/

- As mentioned in the overview, main_marked.js is the only javascript file which I have coded. All other javascript files came
with the template and have not been modified by me at all.
