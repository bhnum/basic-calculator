#include "vartable.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct Node_s
{
    struct Node_s* next;
    char* name;
    double value;
} Node;

// linked list head
static Node* head = NULL;

void setvar(const char* name, double value)
{
    // search for existing variable
    Node** node_ptr = &head;
    while (*node_ptr != NULL)
    {
        if (strcmp(name, (*node_ptr)->name) == 0)
        {
            (*node_ptr)->value = value;
            return;
        }
        node_ptr = &(*node_ptr)->next;
    }
    
    // variable does not exist already, so add a new one
    Node* tail = malloc(sizeof(Node));
    tail->next = NULL;
    tail->value = value;
    tail->name = malloc(strlen(name) + 1);
    strcpy(tail->name, name);
    *node_ptr = tail;
}

bool getvar(const char* name, double* value)
{
    // search for existing variable
    Node* node = head;
    while (node != NULL)
    {
        if (strcmp(name, node->name) == 0)
        {
            *value = node->value;
            return true;
        }
        node = node->next;
    }

    return false;
}
