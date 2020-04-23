from django.http import HttpResponse,HttpResponseNotFound
from django.shortcuts import render,redirect,get_object_or_404
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages

from . import models

def messages_view(request):
    """Private Page Only an Authorized User Can View, renders messages page
       Displays all posts and friends, also allows user to make new posts and like posts
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render private.djhtml
    """
    if request.user.is_authenticated:
        #user_info = list(models.UserInfo.objects.get(user=request.user))
        user_info = models.UserInfo.objects.get(user=request.user)


        # TODO Objective 9: query for posts (HINT only return posts needed to be displayed)
        posts = list(models.Post.objects.order_by('-timestamp'))
        post_limiter = request.session.get("post_limit",1)
        posts_limited = posts[0:post_limiter]

        # TODO Objective 10: check if user has like post, attach as a new attribute to each post

        context = { 'user_info' : user_info
                  , 'posts' : posts_limited }
        return render(request,'messages.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def account_view(request):
    """Private Page Only an Authorized User Can View, allows user to update
       their account information (i.e UserInfo fields), including changing
       their password
    Parameters
    ---------
      request: (HttpRequest) should be either a GET or POST
    Returns
    --------
      out: (HttpResponse)
                 GET - if user is authenticated, will render account.djhtml
                 POST - handle form submissions for changing password, or User Info
                        (if handled in this view)
    """
    if request.user.is_authenticated:
        if request.method == 'POST':
                form = PasswordChangeForm(request.user,request.POST)
                if form.is_valid():
                    user = form.save()
                    update_session_auth_hash(request,user)

        user_info = models.UserInfo.objects.get(user=request.user)
        if request.method == 'POST':
            info_form = models.UserInfoForm(request.POST)
            if info_form.is_valid():
                employment = info_form.cleaned_data['employment']
                location = info_form.cleaned_data['location']
                birthday = info_form.cleaned_data['birthday']
                interest = info_form.cleaned_data['interests']
                user_info.employment = employment
                user_info.location = location
                user_info.birthday = birthday
                interest = models.Interest(label=interest)
                interest.save()
                user_info.interests.add(interest)
                user_info.save()

        form = PasswordChangeForm(request.user)
        info_form = models.UserInfoForm()
        context = { 'user_info' : user_info,
                    'change_form' : form ,
                    'info_form' : info_form}
        return render(request,'account.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def people_view(request):
    """Private Page Only an Authorized User Can View, renders people page
       Displays all users who are not friends of the current user and friend requests
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render people.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        # TODO Objective 4: create a list of all users who aren't friends to the current user (and limit size)
        all_people = list(models.UserInfo.objects.all().exclude(friends__user=user_info.user).exclude(user=user_info.user))
        people_limiter = request.session.get("people_limit",1)
        all_people_limited = all_people[0:people_limiter]
        # TODO Objective 5: create a list of all friend requests to current user
        friend_requests = list(models.FriendRequest.objects.all().filter(to_user=user_info))
        length = len(friend_requests)
        sent_friend_requests = list(models.FriendRequest.objects.all().filter(from_user=user_info))

        context = { 'user_info' : user_info,
                    'all_people_limited' : all_people_limited,
                    'friend_requests' : friend_requests
                    }

        return render(request,'people.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def like_view(request):
    '''Handles POST Request recieved from clicking Like button in messages.djhtml,
       sent by messages.js, by updating the corrresponding entry in the Post Model
       by adding user to its likes field
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postID,
                                a string of format post-n where n is an id in the
                                Post model

	Returns
	-------
   	  out : (HttpResponse) - queries the Post model for the corresponding postID, and
                             adds the current user to the likes attribute, then returns
                             an empty HttpResponse, 404 if any error occurs
    '''
    postIDReq = request.POST.get('postID')
    if postIDReq is not None:
        # remove 'post-' from postID and convert to int
        # TODO Objective 10: parse post id from postIDReq
        postID = postIDReq[5:]

        if request.user.is_authenticated:
            user = models.UserInfo.objects.get(user=request.user)
            # TODO Objective 10: update Post model entry to add user to likes field
            post = models.Post.objects.get(id=postID)
            post.likes.add(user)
            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('like_view called without postID in POST')

def post_submit_view(request):
    '''Handles POST Request recieved from submitting a post in messages.djhtml by adding an entry
       to the Post Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postContent, a string of content

	Returns
	-------
   	  out : (HttpResponse) - after adding a new entry to the POST model, returns an empty HttpResponse,
                             or 404 if any error occurs
    '''
    postContent = request.POST.get('postContent')
    if postContent is not None:
        if request.user.is_authenticated:
            current_user = models.UserInfo.objects.get(user=request.user)
            if request.method == 'POST':
            # TODO Objective 8: Add a new entry to the Post model
                post = models.Post(owner=current_user,content=postContent)
                post.save()



            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('post_submit_view called without postContent in POST')

def more_post_view(request):
    '''Handles POST Request requesting to increase the amount of Post's displayed in messages.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating hte num_posts sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of posts dispalyed

        # TODO Objective 9: update how many posts are displayed/returned by messages_view
        if request.method == 'POST':
            limit = request.session.get("post_limit",1)
            request.session["post_limit"] = limit + 2
        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')

def more_ppl_view(request):
    '''Handles POST Request requesting to increase the amount of People displayed in people.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating the num ppl sessions variable
    '''
    if request.user.is_authenticated:
        #request.session["people_limit"] = 1
        if request.method == 'POST':
            limit = request.session.get("people_limit",1)
            request.session["people_limit"] = limit + 2
            #request.session["people_limit"] = limit + 1

        # update the # of people dispalyed

        # TODO Objective 4: increment session variable for keeping track of num ppl displayed

        #return status='success'
        return HttpResponse()

    return redirect('login:login_view')

def friend_request_view(request):
    '''Handles POST Request recieved from clicking Friend Request button in people.djhtml,
       sent by people.js, by adding an entry to the FriendRequest Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute frID,
                                a string of format fr-name where name is a valid username

	Returns
	-------
   	  out : (HttpResponse) - adds an etnry to the FriendRequest Model, then returns
                             an empty HttpResponse, 404 if POST data doesn't contain frID
    '''
    frID = request.POST.get('frID')
    if frID is not None:
        # remove 'fr-' from frID
        username = frID[3:]

        if request.user.is_authenticated:
            if request.method == 'POST':
                from_user = models.UserInfo.objects.get(user=request.user)
                to_user = models.UserInfo.objects.get(user__id=username)
                #userfrom = models.UserInfo.objects.filter(user=request.user)
                #from_user = models.UserInfo.objects.get(user=request.user)
                #
                # TODO Objective 5: add new entry to FriendRequest
                fr = models.FriendRequest(to_user=to_user,from_user=from_user)
                fr.save()

            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('friend_request_view called without frID in POST')

def accept_decline_view(request):
    '''Handles POST Request recieved from accepting or declining a friend request in people.djhtml,
       sent by people.js, deletes corresponding FriendRequest entry and adds to users friends relation
       if accepted
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute decision,
                                a string of format A-name or D-name where name is
                                a valid username (the user who sent the request)

	Returns
	-------
   	  out : (HttpResponse) - deletes entry to FriendRequest table, appends friends in UserInfo Models,
                             then returns an empty HttpResponse, 404 if POST data doesn't contain decision
    '''
    data = request.POST.get('decision')
    if data is not None:
        # TODO Objective 6: parse decision from data
        decision = 'D'
        if data[0] == 'A':
            decision = 'A'
        data = data[2:]

        if request.user.is_authenticated:
            # TODO Objective 6: delete FriendRequest entry and update friends in both Users
            to_user = models.UserInfo.objects.get(user=request.user)
            from_user = models.UserInfo.objects.get(user__id=data)
            fr = models.FriendRequest.objects.get(to_user=to_user,from_user=from_user)
            fr.delete()
            to_user.friends.add(from_user)
            to_user.save()
            from_user.save()


            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('accept-decline-view called without decision in POST')
