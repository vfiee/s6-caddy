# caddy

自用 caddy 打包

# s6-overlay

## 执行顺序

<!-- 修正权限问题 -->

/etc/fix-attrs.d

<!-- 初始化 -->

/etc/cont-init.d

<!-- 执行服务 -->

/etc/services.d

<!-- 执行结束清理 -->

/etc/cont-finish.d
