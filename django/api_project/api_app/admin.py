from django.contrib import admin
from .models import Comment, Recipe, UserProfile

# Register your models here.
admin.site.register(Recipe)
admin.site.register(Comment)
admin.site.register(UserProfile)