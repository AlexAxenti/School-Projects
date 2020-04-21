from django.db import models
from django.contrib.auth.models import User

class Interest(models.Model):
    label = models.CharField(max_length=30,primary_key=True)

class UserInfoManager(models.Manager):
    def create_user_info(self, username, password):
        user = User.objects.create_user(username=username,
                                    password=password)
        userinfo = self.create(user=user)
        return userinfo

class UserInfo(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                primary_key=True)
    objects = UserInfoManager()
    employment = models.CharField(max_length=30,default='Unspecified')
    location = models.CharField(max_length=50,default='Unspecified')
    birthday = models.DateField(null=True,blank=True)
    interests = models.ManyToManyField(Interest)
    friends = models.ManyToManyField('self')

class Post(models.Model):
    owner = models.ForeignKey(UserInfo,
                              on_delete=models.CASCADE)
    content = models.CharField(max_length=280)
    timestamp = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(UserInfo,
                                   related_name='likes')

class FriendRequest(models.Model):
    to_user = models.ForeignKey(UserInfo,
                                on_delete=models.CASCADE,
                                related_name='to_users')
    from_user = models.ForeignKey(UserInfo,
                                  on_delete=models.CASCADE,
                                  related_name='from_users')
