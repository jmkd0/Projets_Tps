#ifndef TP4
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

typedef struct Tree{
    int value;
    struct Tree *left;
    struct Tree *right;
} Tree;

/* char* create_tree_by_prefix (Tree** tree, char* prefix ){
    int i, size = strlen(prefix);
    
    //if()
    //for(i=0; i< size; i++)
    if(*prefix == '\0') return '\0';
    for(i=0; i< size; i++){
        char* pref="null";
        if(*tree == NULL){
        Tree* node = (Tree*)malloc(sizeof(Tree));
        node->data   = *prefix;
        node->left  = NULL;
        node->right = NULL;
        *tree = node;
        //printf("%c ", *prefix);
        }else{
            if (*prefix >= 'a' && *prefix <= 'z') { 
				return prefix; 
			} 
        pref = create_tree_by_prefix (&(*tree)->left, prefix +1);
        pref = create_tree_by_prefix (&(*tree)->right, pref +1);
        return pref;
        }
    }
}
char* create_tree_by_postfix (Tree** tree, char* postfix ){
    int i, size = strlen(postfix);
    
    //if()
    //for(i=0; i< size; i++)
    if(*postfix == '\0') return '\0';
    for(i=0; i< size; i++){
        char* post="null";
        if(*tree == NULL){
        Tree* node = (Tree*)malloc(sizeof(Tree));
        node->data   = *postfix;
        node->left  = NULL;
        node->right = NULL;
        *tree = node;
        //printf("%c ", *prefix);
        }else{
            
        post = create_tree_by_postfix (&(*tree)->left, postfix +1);
        post = create_tree_by_postfix (&(*tree)->right, post +1);
        if (*postfix >= 'a' && *postfix <= 'z') { 
				return postfix; 
			} 
        return post;
        }
    }
}

Tree* create_tree_by_bfs(Tree* tree, char* bfs, int i, int n) { 
    if (i < n) { 
        Tree* node = (Tree*)malloc(sizeof(Tree)); 
        node->data = *(bfs+i); 
        node->left =  NULL;
        node->right = NULL;
        tree = node; 
  
        // insert left child 
        tree->left = create_tree_by_bfs(tree->left, bfs, 2 * i + 1, n); 
  
        // insert right child 
        tree->right = create_tree_by_bfs(tree->right, bfs, 2 * i + 2, n); 
    } 
    return tree; 
}  */
Tree* create_perfect_tree_by_bfs(Tree* tree, int i, int n) { 
    if (i < n) { 
        Tree* node = (Tree*)malloc(sizeof(Tree)); 
        node->value = i; 
        node->left =  NULL;
        node->right = NULL;
        tree = node; 
  //printf("%d ", i);
        // insert left child 
        tree->left = create_perfect_tree_by_bfs(tree->left, pow(2, i), n); 
  
        // insert right child 
        tree->right = create_perfect_tree_by_bfs(tree->right, pow(2, i)+1, n); 
    } 
    return tree; 
} 
void Prefixev(Tree* arbre){
	if(arbre==NULL) return;
    printf("%d   ",arbre->value);
	Prefixev(arbre->left);
    //printf("%c   ",arbre->data);
	Prefixev(arbre->right);
    //printf("%c   ",arbre->data);
}
/* void addBack (List* list, int value){
    List *node= (List*)malloc(sizeof(List));
    if(node == NULL) return;
    List* end = list;
    while(end->next != NULL) end =end->next;
    node->value = value;
    node->next = NULL;
    end->next = node;
}

int eraseFront (List* list){
     List* first = list->next;
    if ( first == NULL) exit( EXIT_FAILURE) ;
    int front = first->value;
    list->next = list->next->next;
    free(first);
   return front;
}
void parcoursLargeur (Tree* tree){
    if( tree == NULL) return;
    List  *file = &(List){0, NULL};
    addBack (file, tree->data);
    while( file->next != NULL){
        printf("%c ", eraseFront (file));
        if( tree->left != NULL) addBack (file, tree->left->data);
        if( tree->right != NULL) addBack (file, tree->right->data);
    }
} */
#endif