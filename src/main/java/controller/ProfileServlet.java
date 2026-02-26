package controller;

import bean.User;
import bo.UserBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private UserBO userBO;

    @Override
    public void init() throws ServletException {
        userBO = new UserBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ✅ Đảm bảo sử dụng UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin user mới nhất từ database
        User currentUser = userBO.getUserById(user.getId());
        request.setAttribute("user", currentUser);
        request.getRequestDispatcher("/view/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ✅ Đảm bảo sử dụng UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra thông tin nhập vào
        if (fullname == null || phone == null || email == null ||
            fullname.trim().isEmpty() || phone.trim().isEmpty() || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            doGet(request, response);
            return;
        }

        // Cập nhật thông tin cơ bản
        User updatedUser = new User();
        updatedUser.setId(user.getId());
        updatedUser.setFullname(fullname.trim());
        updatedUser.setPhone(phone.trim());
updatedUser.setEmail(email.trim());

        // Nếu có yêu cầu thay đổi mật khẩu
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            if (currentPassword == null || currentPassword.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập mật khẩu hiện tại!");
                doGet(request, response);
                return;
            }

            if (!userBO.validatePassword(user.getId(), currentPassword)) {
                request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                doGet(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu mới không khớp!");
                doGet(request, response);
                return;
            }

            updatedUser.setPassword(newPassword);
        } else {
            updatedUser.setPassword(user.getPassword()); // Không đổi mật khẩu
        }

        // Tiến hành cập nhật
        if (userBO.updateUser(updatedUser)) {
            User newUser = userBO.getUserById(user.getId());
            session.setAttribute("user", newUser);
            request.setAttribute("success", "Cập nhật thông tin thành công!");
            doGet(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra! Vui lòng thử lại.");
            doGet(request, response);
        }
    }
}