package controller;

import bean.User;
import bo.UserBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserBO userBO;

    @Override
    public void init() throws ServletException {
        userBO = new UserBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // Validation
        if (username == null || password == null || confirmPassword == null ||
            fullname == null || phone == null || email == null ||
            username.trim().isEmpty() || password.trim().isEmpty() ||
            confirmPassword.trim().isEmpty() || fullname.trim().isEmpty() ||
            phone.trim().isEmpty() || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }

        if (userBO.checkUsernameExists(username)) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }

        if (userBO.checkEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }

        User user = new User(username, password, fullname, phone, email);
        if (userBO.register(user)) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra! Vui lòng thử lại.");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
        }
    }
}
