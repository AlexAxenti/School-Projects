"""social URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path
from . import views

app_name = 'social'
urlpatterns = [
    path('messages/', views.messages_view,name='messages_view'),
    path('account/', views.account_view,name='account_view'),
    path('people/', views.people_view,name='people_view'),
    path('like/', views.like_view,name='like_view'),
    path('postsubmit/', views.post_submit_view,name='post_submit_view'),
    path('morepost/', views.more_post_view,name='more_post_view'),
    path('moreppl/', views.more_ppl_view,name='more_ppl_view'),
    path('friendrequest/', views.friend_request_view,name='friend_request_view'),
    path('acceptdecline/', views.accept_decline_view,name='accept_decline_view'),
]
