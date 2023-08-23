// System Headers
#include <GL/glew.h>
#include <GLFW/glfw3.h>

// Standard Headers
#include <cstdio>
#include <cstdlib>
#include <iostream>

// Self Headers
#include "TestingClass.h"

// For glew
#define GLEW_STATIC

int testing_function()
{
    TestingClass input(5);

    std::cout << "Saluton Mundo!" << std::endl;
    std::cout << "Input Number 5: " << input.get_value() << std::endl;
    return 0;
}


#define GLEW_STATIC

int main(void)
{
    GLFWwindow* window;

    /* Initialize the library */
    if (!glfwInit())
        return -1;

    /* Create a windowed mode window and its OpenGL context */
    window = glfwCreateWindow(640, 480, "Hello World", NULL, NULL);
    if (!window)
    {
        glfwTerminate();
        return -1;
    }

    /* Make the window's context current */
    glfwMakeContextCurrent(window);

    std::cout << "OpenGL Version: " << glGetString(GL_VERSION) << std::endl;
    testing_function();

    /* Loop until the user closes the window */
    while (!glfwWindowShouldClose(window))
    {
        /* Render here */
        glClear(GL_COLOR_BUFFER_BIT);
        
        glBegin(GL_TRIANGLES);
        glVertex2f( 0.5f, -0.5f);
        glVertex2f(-0.5f, -0.5f);
        glVertex2f( 0.0f,  0.5f);
        glEnd();

        /* Swap front and back buffers */
        glfwSwapBuffers(window);

        /* Poll for and process events */
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}