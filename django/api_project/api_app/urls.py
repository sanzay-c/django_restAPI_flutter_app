from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import CommentViewSet, RecipeViewSet, UserProfileViewset

router = DefaultRouter()
router.register(r'recipe', RecipeViewSet)
router.register(r'comment', CommentViewSet)
router.register(r'user-profile', UserProfileViewset)

urlpatterns = router.urls