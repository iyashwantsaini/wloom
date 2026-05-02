/// Discrete size step shared by every Wolwoloom component.
///
/// `sm` is dense / table-like, `md` is the default, `lg` is hero-sized.
enum WlmSize { sm, md, lg }

/// Resolves a numeric value per [WlmSize] step.
T wlmBySize<T>(WlmSize size, {required T sm, required T md, required T lg}) =>
    switch (size) {
      WlmSize.sm => sm,
      WlmSize.md => md,
      WlmSize.lg => lg,
    };
