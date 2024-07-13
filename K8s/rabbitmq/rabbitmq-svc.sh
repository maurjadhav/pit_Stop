---
apiVersion: v1
kind: Service
metadata:
  name: rabbitmq-svc
spec:
  type: LoadBalancer
  ports:
  - name: port1
    targetPort: 5672
    port: 5672
    protocol: TCP
  - name: port2
    targetPort: 15672
    port: 15672
    protocol: TCP
  selector:
    app: rabbitmq