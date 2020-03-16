$(document).ready(function(){

    

    //Mouse event for highlighting the text and icons located in the "Skills and Information" section.
    $(".highlight").mouseenter(function(){
        
        $(this).css("background-color","#AFEEEE");
        
    });
    
    $(".highlight").mouseleave(function(){
        
        $(this).css("background-color","#FFFFFF");
        
    });  
    
    
    //Mouse event to bolden and enlarge the the text on the navigator
    $(".bolden").mouseenter(function(){
        
        $(this).css("font-weight","bold"); 
        $(this).css("font-size","17.75px")
    });
    
    $(".bolden").mouseleave(function(){
        
        $(this).css("font-weight","normal");  
        $(this).css("font-size","17.5px")
    });

    
    //Animation for the three icons at the bottom of the navigator, causes them to swell while hovering, and shrink after mouse is removed.
    $(".bubble").hover(growHeight,shrinkHeight);
    
    function growHeight(){
        $(this).stop(true,false).animate({height: "40"},300);
    }
    
    function shrinkHeight(){
        $(this).stop(true,false).animate({height: "35"},300);
    }
    
    
    //The following lines cause the pictures under the "Projects" section to change when clicked on. This is done to show multiple pictures of the project I am describing.
    //The code for pictures 1 to 3 are identical just different variable names according to picture number
    
    //Picture 1
    const pic1 = "images/pic01"
    var count1 = 0
    
    $("#pic01").click(function(){
        
        count1+=1;
        if(count1 == 2){
            source = pic1 + ".png";
            count1 = 0
        }
        else{
            source = pic1 + "0" + count1.toString() + ".png"; 
        }
        
        $(this).attr("src",source);
    });
    
    //Picture 2    
    const pic2 = "images/pic02"
    var count2 = 0
    
    $("#pic02").click(function(){
        
        count2+=1;
        if(count2 == 2){
            source = pic2 + ".png";
            count2 = 0
        }
        else{
            source = pic2 + "0" + count2.toString() + ".png"; 
        }
        
        $(this).attr("src",source);
    });

    //Picture 3    
    const pic3 = "images/pic03"
    var count3 = 0
    
    $("#pic03").click(function(){
        
        count3+=1;
        if(count3 == 4){
            source = pic3 + ".png";
            count3 = 0
        }
        else{
            source = pic3 + "0" + count3.toString() + ".png"; 
        }
        
        $(this).attr("src",source);
    });
    
    
    //Code for changing the paragraph under the "Skills and Information" section to display the text relevant to the category selected.
    
    //The 6 consts are the html that will be changed when a category is selected
    
    const education = "<b>Education </b><br><br> - Computer Science at McMaster University (2019-Present) <br> - Completed highschool diploma at M.M. Robinson Highschool (2019) <br> - Lester B. Pearson Highschool (2015-2018)"
    
    const achieve = "<b>Achievements</b><br><br> - Completed the Canadian Business Health Management training for Management/Leadership and Customer Service. <br> - Global Harmonized System WHMIS Awareness Training certified. <br> - Standard First Aid with CPR C issued by Lifesaving Society. <br> - Received grade 12 Computer Science award for highest mark."
    
    const workexp = "<b> Work Experience </b> <br> <br> <b> Control System Innovators - Junior Technician (July - August 2018) </b> <br> - Worked with Allen Bradley and Siemens PLCs, while programming attached HMIs with Visual Basic. <br> - Extensive testing of execution of programmable controllers along with attatched components. <br> - Plenty of use of Microsoft programs (Word, Excel, Etc.) to complete any work orders. <br> - Collaborated with engineers towards design and completion of various tasks. <br> <br> <b> Frescho - Meat Clerk (December 2018 - August 2019) </b> <br> - Assisted customers daily with various tasks. <br> - Provided exellent curstomer service to clients. <br> - Coordinated with team members to ensure efficient completion of tasks."
    
    const programexp = "<b>Programming Experience</b><br><br><b>Python</b><br> - I have programmed classes, machine learning, webscraping, graphics and more using python. <br> - Knowledge about virtual environments and many python libraries. <br><br> <b> C# </b> <br> - Use of C# for multiple Unity3D projects. <br> - Lots of practice with classes and objects, as well as 2d and 3dvectors and graphics. <br> - Practiced working with a team over cloud. <br><br> <b>Java</b> <br> - I have used Java alongside MySQL to program databases and a user authentication system with encryption. <br> - Programmed sorting algorithms and graphics. <br><br><b>C++</b><br> - Basic knowledge of C++ such as functions, vectors and arrays, sorting algorithms, and classes."
    
    const extracur = "<b>Extracurriculars</b><br><br> <b>Highschool Robotics Club</b> <br> - Worked with other students on designing and planning the creation and programming of a robot. <br> - Gained plenty of teamwork and communication skills. <br> <b>Highschool Link Crew leader</b><br>- Worked with other club members to plan and organize events. <br> - Helped younger students by giving tours, discussing highschool issues, etc.<br><b>Participated in hackathons</b><br> - Learned a lot about teamwork from planning and designing a project with others. <br> - Gained valuable leaderships skills from tasks such as assigning roles and deciding the steps in fulfilling our plan.<br><b>Volunteered as swimming instructor</b><br>- Learned plenty of communication skills from teaching children to swim and assisting them in overcoming problems. "
    
    const genskill = "<b>General Skills</b><br><br> - I have a lot of teamwork and communication skills from events such as hackathons, working at an engineering firm, clubs, etc. <br> - Leadership and organization skills from volunteering, clubs, and hackathons. <br> - Hardworking and great problem solving skills from plenty of course work such as calculus and multiple computer science courses."
    
    //This mousedown event takes care of detecting which category was selecting and changing the html of the correct paragraph element
    
    $(".highlight").mousedown(function(){
       
        var elemClass = $(this).attr("class");
        elemClass = elemClass.slice(21,elemClass.length);
        
        console.log(elemClass)
        
        if(elemClass == "fa-book"){
            $("#skillsinfo").html(education)
        }
        else if(elemClass == "fa-medal"){
            $("#skillsinfo").html(achieve)
        }
        else if(elemClass == "fa-hammer"){
            $("#skillsinfo").html(workexp)
        }
        else if(elemClass == "fa-code"){
            $("#skillsinfo").html(programexp)
        }
        else if(elemClass == "fa-users"){
            $("#skillsinfo").html(extracur)
        }
        else if(elemClass == "fa-check"){
            $("#skillsinfo").html(genskill)
        }
        
    });

});