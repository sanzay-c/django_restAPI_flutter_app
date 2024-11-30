from rest_framework import viewsets
from .models import Recipe, Comment, UserProfile
from .serializers import UserProfileSerializer, CommentSerializer, RecipeSerializer
from rest_framework.decorators import action
from rest_framework.response import Response

# Create your views here.
class RecipeViewSet(viewsets.ModelViewSet):
    queryset = Recipe.objects.all()
    serializer_class = RecipeSerializer

    # Custom search route
    @action(detail=False, methods=['get'])
    def search(self, request):
        query = request.GET.get('query', '')  # Get the search query from the request
        
        if query:
            # Perform case-insensitive search for recipes
            recipes = Recipe.objects.filter(recipe_name__icontains=query)
        else:
            recipes = Recipe.objects.all()

        # Serialize and return the filtered recipes
        serializer = self.get_serializer(recipes, many=True)
        return Response(serializer.data)
    
class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer

class UserProfileViewset(viewsets.ModelViewSet):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer
