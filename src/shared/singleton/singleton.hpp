#pragma once

namespace common {
template <typename T> class Singleton {
  public:
    [[nodiscard]]
    static T& instance() noexcept {
        static T ls_instance{};
        return ls_instance;
    }
    Singleton(Singleton const&) = delete;
    Singleton& operator=(Singleton const&) = delete;
    Singleton&& operator=(Singleton const&) = delete;
    Singleton& operator=(Singleton&&) = delete;

  protected:
    Singleton() = default;

  private:
}; // Singleton
} // namespace common